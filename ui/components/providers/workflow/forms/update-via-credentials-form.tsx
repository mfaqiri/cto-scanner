"use client";

import { updateCredentialsProvider } from "@/actions/providers/providers";
import { useToast } from "@/components/ui";
import { CustomButton } from "@/components/ui/custom";
//import { ProviderType } from "@/components/ui/entities";
import { Form } from "@/components/ui/form";
import {
  addCredentialsFormSchema,
  ApiError,
  AWSCredentials,
  AzureCredentials,
  GCPCredentials,
  KubernetesCredentials,
  M365Credentials,
} from "@/types";

//import { ProviderTitleDocs } from "../provider-title-docs";
import { AWScredentialsForm } from "./via-credentials/aws-credentials-form";
import { AzureCredentialsForm } from "./via-credentials/azure-credentials-form";
import { GCPcredentialsForm } from "./via-credentials/gcp-credentials-form";
import { KubernetesCredentialsForm } from "./via-credentials/k8s-credentials-form";
import { M365CredentialsForm } from "./via-credentials/m365-credentials-form";

type CredentialsFormSchema = z.infer<
  ReturnType<typeof addCredentialsFormSchema>
>;

// Add this type intersection to include all fields
type FormType = CredentialsFormSchema &
  AWSCredentials &
  AzureCredentials &
  M365Credentials &
  GCPCredentials &
  KubernetesCredentials;

export const UpdateViaCredentialsForm = ({
  searchParams,
}: {
  searchParams: { type: string; id: string; secretId?: string };
}) => {
  const providerType = searchParams.type as ProviderType;
  const providerId = searchParams.id;
  const providerSecretId = searchParams.secretId || "";

  const handleUpdateCredentials = async (formData: FormData) => {
    return await updateCredentialsProvider(providerSecretId, formData);
  };

  const successNavigationUrl = `/providers/test-connection?type=${providerType}&id=${providerId}&updated=true`;

  return (
    <Form {...form}>
      <form
        onSubmit={form.handleSubmit(onSubmitClient)}
        className="flex flex-col space-y-4"
      >
        <input type="hidden" name="providerId" value={providerId} />
        <input type="hidden" name="providerType" value={providerType} />

        {/*<ProviderTitleDocs providerType={providerType as ProviderType} />*/}

        <Divider />

        {providerType === "aws" && (
          <AWScredentialsForm
            control={form.control as unknown as Control<AWSCredentials>}
          />
        )}
        {providerType === "azure" && (
          <AzureCredentialsForm
            control={form.control as unknown as Control<AzureCredentials>}
          />
        )}
        {providerType === "m365" && (
          <M365CredentialsForm
            control={form.control as unknown as Control<M365Credentials>}
          />
        )}
        {providerType === "gcp" && (
          <GCPcredentialsForm
            control={form.control as unknown as Control<GCPCredentials>}
          />
        )}
        {providerType === "kubernetes" && (
          <KubernetesCredentialsForm
            control={form.control as unknown as Control<KubernetesCredentials>}
          />
        )}

        <div className="flex w-full justify-end sm:space-x-6">
          {searchParamsObj.get("via") === "credentials" && (
            <CustomButton
              type="button"
              ariaLabel="Back"
              className="w-1/2 bg-transparent"
              variant="faded"
              size="lg"
              radius="lg"
              onPress={handleBackStep}
              startContent={!isLoading && <ChevronLeftIcon size={24} />}
              isDisabled={isLoading}
            >
              <span>Back</span>
            </CustomButton>
          )}
          <CustomButton
            type="submit"
            ariaLabel={"Save"}
            className="w-1/2"
            variant="solid"
            color="action"
            size="lg"
            isLoading={isLoading}
            endContent={!isLoading && <ChevronRightIcon size={24} />}
          >
            {isLoading ? <>Loading</> : <span>Next</span>}
          </CustomButton>
        </div>
      </form>
    </Form>
  );
};

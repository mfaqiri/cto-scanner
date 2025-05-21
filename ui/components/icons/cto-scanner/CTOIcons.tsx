import { ImageProps } from "@nextui-org/react";
import React from "react";

import Image from "next/image";

import { ctosmallogo, ctoextendedlogo } from "../compliance/IconCompliance";

export const CTOIconExtended: React.FC<ImageProps> = () => {
  return (
      <Image
        src={ctoextendedlogo()}
        alt="Large CTO logo."
      />
  );
};

export const CTOIconShort: React.FC<ImageProps> = () => {
  return (
      <Image
        src={ctosmallogo()}
        alt="Small CTO logo."
      />
  );
};

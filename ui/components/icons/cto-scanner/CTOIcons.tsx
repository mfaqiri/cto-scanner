import { ImageProps } from "@nextui-org/react";
import React from "react";

import logo3x from "../../../public/logo-3x.webp";
import logosmall from "../../../public/logo-small.png";

export const CTOIconExtended: React.FC<ImageProps> = ({ width }) => {
  return (
    <div>
      <style>
        {`img {
                        max-width: 200%;
                }`}
      </style>
      <img src={(logo3x as HTMLImageElement).src} width={width} alt="Large CTO logo." />
    </div>
  );
};

export const CTOIconShort: React.FC<ImageProps> = ({ width }) => {
  return (
    <div>
      <style>
        {`img {
                        max-width: 150%;
                }`}
      </style>
      <img src={(logosmall as HTMLImageElement).src} width={width} alt="Small CTO logo." />
    </div>
  );
};

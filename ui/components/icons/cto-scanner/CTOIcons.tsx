import React from "react";

import { ImageProps } from "@nextui-org/react";
import logo3x from "../../../public/logo-3x.png";
import logosmall from "../../../public/logo-small.png";

export const CTOIconExtended: React.FC<ImageProps> = ({
    height,
    width = 240,
}) => {
    return(
        <div>
            <style>
                {
                 `   img {
                        max-width: 200%;


                    }`

                }
            </style>
        <img src={logo3x.src} width={width} height={height} />
        </div>
        );
    };

export const CTOIconShort: React.FC<ImageProps> = ({
    width = 75,
}) => {
        

        return (
        <div>
            <style>
                {
                 `   img {
                        max-width: 150%;


                    }`

                }
            </style>
            <img src={logosmall.src} width={width}/>
        </div>
        );
    
  };

import { useState } from "react";
import { ModeToggle } from "../components/themeMenu";

import {
  Menubar,
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarSeparator,
  MenubarShortcut,
  MenubarSub,
  MenubarSubTrigger,
  MenubarSubContent,
} from "@/components/ui/menubar";

import Product from "../product/Product";
import { MenubarTrigger } from "@radix-ui/react-menubar";

export function Menu() {
  // State to manage the visibility of the Product form
  const [isProductFormVisible, setProductFormVisible] = useState(false);

  // Function to handle the click on the "Produto" menu item
  const handleProdutoClick = () => {
    // Open the Product form by setting the state to true
    setProductFormVisible(true);
  };

  return (
    <div>
      <Menubar className=" size-2/12 w-full  ">
        <div className="p-3 max-w-64 mx-auto ">
          <div>
            <Menubar className="border">
              <MenubarMenu>
                <MenubarTrigger className="cursor-pointer w-64">
                  Menu Principal
                </MenubarTrigger>
                <MenubarContent>
                  <MenubarSub>
                    <MenubarSubTrigger>
                      Cadastro <MenubarShortcut>⌘C</MenubarShortcut>
                    </MenubarSubTrigger>
                    <MenubarSubContent>
                      {/* Attach the click handler to the "Produto" menu item */}
                      <MenubarItem onClick={handleProdutoClick}>
                        Produtos
                      </MenubarItem>
                      <MenubarItem>Pessoas</MenubarItem>
                    </MenubarSubContent>
                  </MenubarSub>
                  <MenubarSeparator />
                  <MenubarSub>
                    <MenubarSubTrigger>
                      Relatórios<MenubarShortcut>⌘R</MenubarShortcut>
                    </MenubarSubTrigger>
                    <MenubarSubContent>
                      <MenubarItem disabled>Produtos</MenubarItem>
                      <MenubarItem disabled>Pessoas</MenubarItem>
                    </MenubarSubContent>
                  </MenubarSub>
                </MenubarContent>
              </MenubarMenu>
            </Menubar>
          </div>
        </div>
        <ModeToggle />
      </Menubar>

      {/* Render the Product form based on the state */}
      {isProductFormVisible && <Product />}
    </div>
  );
}

import { useState } from "react";
import { ModeToggle } from "../components/themeMenu";
import { MenubarTrigger } from "@radix-ui/react-menubar";

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
import Person from "../person/Person";

export function Menu() {
  const [isProductFormVisible, setProductFormVisible] = useState(false);
  const [isPersonFormVisible, setPersonFormVisible] = useState(false);

  const handleProdutoClick = () => {
    setProductFormVisible(true);
    setPersonFormVisible(false);
  };

  const handlePersonClick = () => {
    setPersonFormVisible(true);
    setProductFormVisible(false);
  };

  return (
    <div>
      <Menubar className="size-2/12 w-full">
        <div className="p-3 max-w-64 mx-auto">
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
                      <MenubarItem onClick={handleProdutoClick}>
                        Produtos
                      </MenubarItem>
                      <MenubarItem onClick={handlePersonClick}>
                        Pessoas
                      </MenubarItem>
                    </MenubarSubContent>
                  </MenubarSub>
                  <MenubarSeparator />
                  <MenubarSub>
                    <MenubarSubTrigger>
                      Relatórios <MenubarShortcut>⌘R</MenubarShortcut>
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

      {isProductFormVisible && <Product />}
      {isPersonFormVisible && <Person />}
    </div>
  );
}

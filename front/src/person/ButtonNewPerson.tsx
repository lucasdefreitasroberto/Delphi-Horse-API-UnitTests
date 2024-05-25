import { Button } from "@/components/ui/button";
import { PlusCircle } from "lucide-react";

import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";

export default function ButtonNewProduct() {
  return (
    <div>
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="default" className="bg-[#166534]">
            <PlusCircle className="w-4 h-4 mr-2" />
            Nova Pessoa
          </Button>
        </SheetTrigger>
        <SheetContent side="top">
          {/* Alterado o lado para "right", pode ser ajustado conforme necessidade */}
          <SheetHeader>
            <SheetTitle>Cadastro de Pessoa</SheetTitle>
          </SheetHeader>
          <div className="grid gap-3 py-4">
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="name" className="text-right">
                Nome
              </Label>
              <Input id="name" className="col-span-3" />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="sexo" className="text-right">
                Sexo
              </Label>
              <Input id="sexo " className="col-span-1" />

              <Label htmlFor="tipo" className="text-right">
                Tipo
              </Label>
              <Input id="tipo" className="col-span-1" />

              <Label htmlFor="cpfcnpj" className="text-right">
                CPF / CNPJ
              </Label>
              <Input id="cpfcnpj" className="col-span-1" />
            </div>

            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="name" className="text-right">
                Bairro
              </Label>
              <Input id="name" className="col-span-3" />

              <Label htmlFor="estado" className="text-right">
                Estado
              </Label>
              <Input id="estado" className="col-span-1" />

              <Label htmlFor="cidade" className="text-right">
                Cidade
              </Label>
              <Input id="cidade" className="col-span-1" />

              <Label htmlFor="complemento" className="text-right">
                Complemento
              </Label>
              <Input id="complemento" className="col-span-3" />
            </div>

          </div>
          <SheetFooter>
            <SheetClose asChild>
              <Button type="submit">Salvar</Button>
            </SheetClose>
          </SheetFooter>
        </SheetContent>        
      </Sheet>
    </div>
  );
}

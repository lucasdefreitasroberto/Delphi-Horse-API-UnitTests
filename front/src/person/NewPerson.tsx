import { useState } from "react";
import { Button } from "@/components/ui/button";
import { PlusCircle } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import api from "../service/api";

export default function NewPerson() {
  const [formData, setFormData] = useState({
    nome: String,
    sexo: String,
    tipo: String,
    CPFCNPJ: Number,
    bairro: String,
    estado: String,
    cidade: String ,
    complemento: String
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({
      ...formData,
      [name]: value
    });
  };

  const handleSelectChange = (name, value) => {
    setFormData({
      ...formData,
      [name]: value
    });
  };

  const handleSaveClick = async () => {
    const { nome, sexo, tipo, CPFCNPJ, bairro, estado, cidade, complemento } = formData;

    try {
      const response = await api.post("/person", {
        nome: nome,
        sexo: sexo,
        tipo: tipo,
        CPFCNPJ: CPFCNPJ,
        bairro: bairro,
        estado: estado,
        cidade: cidade,        
        complemento: complemento
      });

      console.log("Produto salvo:", response.data);

      // Recarrega a página após o POST bem-sucedido
      window.location.reload();
    } catch (error) {
      console.error("Erro ao salvar produto:", error);
    }
  };

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
          <SheetHeader>
            <SheetTitle>Cadastro de Pessoa</SheetTitle>
          </SheetHeader>

          <div className="grid gap-3 py-4">
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="nome" className="text-right">
                Nome
              </Label>
              <Input
                id="nome"
                name="nome"
                className="col-span-3"
                value={formData.nome}
                onChange={handleInputChange}
              />
            </div>

            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="sexo" className="text-right">
                Sexo
              </Label>
              <Select
                onValueChange={(value) => handleSelectChange("sexo", value)}
              >
                <SelectTrigger className="w-[180px]">
                  <SelectValue placeholder="Sexo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="M">Masculino</SelectItem>
                  <SelectItem value="F">Feminino</SelectItem>
                </SelectContent>
              </Select>

              <Label htmlFor="tipo" className="text-right">
                Tipo
              </Label>
              <Select
                onValueChange={(value = " ") => handleSelectChange("tipo", value)}
              >
                <SelectTrigger className="w-[180px]">
                  <SelectValue placeholder="Tipo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="F">Físico</SelectItem>
                  <SelectItem value="J">Jurídico</SelectItem>
                </SelectContent>
              </Select>

              <Label htmlFor="CPFCNPJ" className="text-right">
                CPF / CNPJ
              </Label>
              <Input
                id="CPFCNPJ"
                name="CPFCNPJ"
                className="col-span-1"
                type="text"
                value={formData.CPFCNPJ}
                onChange={handleInputChange}
              />
            </div>

            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="bairro" className="text-right">
                Bairro
              </Label>
              <Input
                id="bairro"
                name="bairro"
                className="col-span-3"
                value={formData.bairro}
                onChange={handleInputChange}
              />

              <Label htmlFor="estado" className="text-right">
                Estado
              </Label>
              <Input
                id="estado"
                name="estado"
                className="col-span-1"
                value={formData.estado}
                onChange={handleInputChange}
              />

              <Label htmlFor="cidade" className="text-right">
                Cidade
              </Label>
              <Input
                id="cidade"
                name="cidade"
                className="col-span-1"
                value={formData.cidade}
                onChange={handleInputChange}
              />

              <Label htmlFor="complemento" className="text-right">
                Complemento
              </Label>
              <Input
                id="complemento"
                name="complemento"
                className="col-span-3"
                value={formData.complemento}
                onChange={handleInputChange}
              />
            </div>
          </div>

          <SheetFooter>
            <SheetClose asChild>
              <Button onClick={handleSaveClick}>Salvar</Button>
            </SheetClose>
          </SheetFooter>
        </SheetContent>
      </Sheet>
    </div>
  );
}

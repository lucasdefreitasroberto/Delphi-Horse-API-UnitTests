import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

import { ButtonDelete } from "@/buttonAction/btnDelete";
import { ButtonEdit } from "@/buttonAction/btnEdit";

import manImage from '../../public/man.png';
import womanImage from '../../public/woman.png';


import api from "../service/api";
import { useEffect, useState } from "react";

const getGenderImage = (gender: string) => {
  if (gender === 'M') return manImage;
  if (gender === 'F') return womanImage;
  return null;
};


const formatType = (gender: string) => {
  if (gender === "F") return "Física";
  if (gender === "J") return "Jurídica";
  return gender;
};

function capitalizeWords(text: string): string {
  return text
    .split(" ")
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(" ");
}

export default function Grid() {
  const [person, setPerson] = useState<
    {
      id: number;
      nome: string;
      sexo: string;
      tipo: string;
      cpfcnpj: number;
      bairro: string;
      cidade: string;
      estado: string;
      complemento: string;
    }[]
  >([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await api.get("/person/");
        setPerson(response.data);
        console.log(response.data);
      } catch (error) {
        console.error("Erro ao buscar a pessoa:", error);
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      <Table>
        <TableCaption>Lista de todas as Pessoas.</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className="w-[50px]">Código</TableHead>
            <TableHead className="w-[600px]">Nome</TableHead>
            <TableHead className="w-[50px]">Sexo</TableHead>
            <TableHead className="w-[50px]">Tipo</TableHead>
            <TableHead className="w-[50px]">CPF/CNPJ</TableHead>
            <TableHead className="w-[200px]">Bairro</TableHead>
            <TableHead className="w-[200px]">Cidade</TableHead>
            <TableHead className="w-[20px]">Estado</TableHead>
            <TableHead className="w-[200px]">Complemento</TableHead>
            <TableHead className="w-[50px]">Ações</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {person.map((p) => (
            <TableRow key={p.id}>
              <TableCell className="font-medium">{p.id}</TableCell>
              <TableCell>{capitalizeWords(p.nome)}</TableCell>
              {/* <TableCell>{(p.sexo)}</TableCell> */}
              <TableCell><img src={getGenderImage(p.sexo)} alt={p.sexo === 'M' ? 'Man' : 'Woman'} width="32" height="32" /></TableCell>
              <TableCell>{formatType(p.tipo)}</TableCell>
              <TableCell>{p.cpfcnpj}</TableCell>
              <TableCell>{capitalizeWords(p.bairro)}</TableCell>
              <TableCell>{capitalizeWords(p.cidade)}</TableCell>
              <TableCell>{p.estado}</TableCell>
              <TableCell>{capitalizeWords(p.complemento)}</TableCell>
              <TableCell className="text-right space-x-1">
                <ButtonEdit />
                <ButtonDelete />
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}

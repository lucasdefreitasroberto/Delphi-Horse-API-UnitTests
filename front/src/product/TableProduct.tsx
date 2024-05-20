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

export default function Grid(){
    return (
        <Table>
        <TableCaption>Lista de todos os produtos.</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className="w-[100px]">Código</TableHead>
            <TableHead className="w-[600px]">Descrição</TableHead>
            <TableHead className="w-[200px]">Preço</TableHead>
            <TableHead className="text-left ">Ações</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          <TableRow>
            <TableCell className="font-medium">0001</TableCell>
            <TableCell>PNEU</TableCell>
            <TableCell>R$ 100,00</TableCell>
            <TableCell className="text-right space-x-3">
              <ButtonEdit />
              <ButtonDelete />
            </TableCell>
          </TableRow>
        </TableBody>
      </Table>
    )
}
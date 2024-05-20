import { Button } from "@/components/ui/button";
import { Search } from "lucide-react";

export default function Filter() {
  return (
    <form className="flex items-center gap-2">
      <input type="id" placeholder="ID do Pedido" />
      <input type="produto" placeholder="Nome do produto" />
      <Button type="submit" variant="outline">
        <Search className="w-4 h-3 mr-2" />
        Filtrar resultados
      </Button>
    </form>
  );
}

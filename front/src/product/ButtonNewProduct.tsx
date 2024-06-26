import { Button } from "@/components/ui/button";
import { PlusCircle } from "lucide-react";

export default function ButtonNewProduct() {
  return (
    <div>
      <Button variant="default" className="bg-[#166534]">
        <PlusCircle className="w-4 h-4 mr-2" />
        Novo Produto
      </Button>
    </div>
  );
}

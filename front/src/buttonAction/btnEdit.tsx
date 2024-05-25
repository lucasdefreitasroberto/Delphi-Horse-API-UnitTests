import { Button } from "@/components/ui/button";
import { PencilLine } from "lucide-react";

export function ButtonEdit() {
  return (
    <Button variant={"default"} className="text-[10px] h-5 w-14 bg-[#1da1f2]" >
      <PencilLine className="w-3 h-4 mr-1" />
      Editar
    </Button>
  );
}

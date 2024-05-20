import { Button } from "@/components/ui/button";
import { PencilLine } from "lucide-react";

export function ButtonEdit() {
  return (
    <Button variant="default" className="text-[11px] h-6 w-15">
      <PencilLine className="w-3 h-4 mr-1" />
      Editar
    </Button>
  );
}

import { Button } from "@/components/ui/button";
import { XCircle } from "lucide-react";

export function ButtonDelete() {
  return (
    <Button variant="destructive" className="text-[11px] h-6 w-15">
      <XCircle className="w-3 h-3 mr-1" />
      Excluir
    </Button>
  );
}

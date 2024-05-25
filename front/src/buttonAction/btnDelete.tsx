import { Button } from "@/components/ui/button";
import { XCircle } from "lucide-react";

export function ButtonDelete() {
  return (
    <Button variant={"default"} className="text-[10px] h-5 w-14 bg-[#b91c1c]">
      <XCircle className="w-3 h-3 mr-1" />
      Excluir
    </Button>
  );
}

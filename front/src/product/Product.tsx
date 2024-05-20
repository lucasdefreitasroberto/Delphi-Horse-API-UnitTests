import Filter from "./FilterProduct";
import ButtonNewProduct from "./ButtonNewProduct";
import Grid from "./TableProduct";

export default function FormProduct() {
  return (
    <div className="p-6 max-w-6xl mx-auto space-y-4">
      <h1 className="text-3xl font-bold">Produto</h1>
      <div className="flex items-center justify-between">
        <Filter />
        <ButtonNewProduct />
      </div>
      <Grid />
    </div>
  );
}

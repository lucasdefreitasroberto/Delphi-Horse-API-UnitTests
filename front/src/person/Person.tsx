import Filter from "./FilterPerson";
// import ButtonNewProduct from "./ButtonNewPerson";
import NewPerson from "./NewPerson";
import Grid from "./TablePerson";

export default function FormProduct() {
  return (
    <div className="p-10  mx-auto space-y-4">
      <h1 className="text-3xl font-bold">Pessoa</h1>
      <div className="flex items-center justify-between">
        <Filter />
        <NewPerson />
      </div>
      <Grid />
    </div>
  );
}

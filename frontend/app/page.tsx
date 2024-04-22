import AddForm from "@/components/AddForm";
import PanelTable from "@/components/PanelTable";
import StockTable from "@/components/StockTable";
import { BsStack } from "react-icons/bs";
import { TfiLayoutSliderAlt } from "react-icons/tfi";

export default function Home() {
  return (
    <main className="flex min-h-screen w-[60rem] md:w-[40rem]  p-8 flex-col gap-2 border-r-2 border-solid border-black">
      {/* <AddForm /> */}
      {/* <AddForm title="Panels" icon={<TfiLayoutSliderAlt />} type="panel" /> */}
      <PanelTable title="Panels" icon={<TfiLayoutSliderAlt />} type="panel" />
      {/* <AddForm title="Stock Sheets" icon={<BsStack />} type="stock" /> */}
      <StockTable title="Stock Sheets" icon={<BsStack />} type="stocks" />
    </main>
  );
}

import AddForm from "@/components/AddForm";
import { BsStack } from "react-icons/bs";
import { TfiLayoutSliderAlt } from "react-icons/tfi";

export default function Home() {
  return (
    <main className="flex min-h-screen w-96 p-8 flex-col gap-6">
      <AddForm title="Panels" icon={<TfiLayoutSliderAlt />} />
      <AddForm title="Stock Sheets" icon={<BsStack />} />
    </main>
  );
}

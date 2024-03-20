import AddForm from "@/components/AddForm";

export default function Home() {
  return (
    <main className="flex min-h-screen w-96 p-8 flex-col gap-6 border-r-2 border-solid border-black">
      <AddForm />
      {/* <AddForm title="Panels" icon={<TfiLayoutSliderAlt />} type="panel" /> */}
      {/* <AddForm title="Stock Sheets" icon={<BsStack />} type="stock" /> */}
    </main>
  );
}

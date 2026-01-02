import { Button } from "@repo/ui";
import Link from "next/link";

const SERVICES = [
    { id: 1, name: "Grand Ball Room", type: "Venue", price: "$2000", image: "https://via.placeholder.com/300" },
    { id: 2, name: "John Doe Photography", type: "Photographer", price: "$500", image: "https://via.placeholder.com/300" },
    { id: 3, name: "Elegant Decor", type: "Decorator", price: "$1200", image: "https://via.placeholder.com/300" },
    { id: 4, name: "DJ Party", type: "Entertainment", price: "$300", image: "https://via.placeholder.com/300" },
];

export default function BrowsePage() {
    return (
        <main className="flex min-h-screen flex-col items-center p-24">
            <h1 className="text-4xl font-bold mb-8">Browse Services</h1>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 w-full max-w-6xl">
                {SERVICES.map((service) => (
                    <div key={service.id} className="border rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition-shadow">
                        <img src={service.image} alt={service.name} className="w-full h-48 object-cover" />
                        <div className="p-4">
                            <h2 className="text-xl font-semibold mb-2">{service.name}</h2>
                            <p className="text-gray-600 mb-2">{service.type}</p>
                            <p className="text-green-600 font-bold mb-4">{service.price}</p>
                            <Button className="w-full">Book Now</Button>
                        </div>
                    </div>
                ))}
            </div>

            <div className="mt-12">
                <Link href="/" className="text-blue-500 hover:underline">
                    Back to Home
                </Link>
            </div>
        </main>
    );
}

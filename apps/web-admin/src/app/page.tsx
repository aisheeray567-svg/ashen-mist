export default function Home() {
    return (
        <main className="flex min-h-screen flex-col items-center justify-between p-24">
            <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm lg:flex">
                <p className="fixed left-0 top-0 flex w-full justify-center border-b border-gray-300 bg-gradient-to-b from-zinc-200 pb-6 pt-8 backdrop-blur-2xl dark:border-neutral-800 dark:bg-zinc-800/30 dark:from-inherit lg:static lg:w-auto  lg:rounded-xl lg:border lg:bg-gray-200 lg:p-4 lg:dark:bg-zinc-800/30">
                    Admin Dashboard
                </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 w-full max-w-5xl">
                <div className="p-6 bg-white rounded-lg shadow-md">
                    <h2 className="text-xl font-bold mb-2">Users</h2>
                    <p className="text-3xl font-bold text-blue-600">1,234</p>
                </div>
                <div className="p-6 bg-white rounded-lg shadow-md">
                    <h2 className="text-xl font-bold mb-2">Events</h2>
                    <p className="text-3xl font-bold text-green-600">567</p>
                </div>
                <div className="p-6 bg-white rounded-lg shadow-md">
                    <h2 className="text-xl font-bold mb-2">Bookings</h2>
                    <p className="text-3xl font-bold text-purple-600">89</p>
                </div>
            </div>
        </main>
    );
}

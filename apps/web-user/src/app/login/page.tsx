"use client";

import { useState } from "react";
import { Button, Input } from "@repo/ui";
import Link from "next/link";

export default function LoginPage() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        console.log("Login with:", email, password);
        // TODO: Call API
    };

    return (
        <div className="flex min-h-screen flex-col items-center justify-center py-2">
            <main className="flex w-full flex-1 flex-col items-center justify-center px-20 text-center">
                <h1 className="text-4xl font-bold mb-8">Login to Wedding Planner</h1>

                <form onSubmit={handleLogin} className="w-full max-w-xs">
                    <div className="mb-4">
                        <Input
                            type="email"
                            placeholder="Email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            className="mb-4"
                        />
                        <Input
                            type="password"
                            placeholder="Password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </div>
                    <Button type="submit" className="w-full">
                        Sign In
                    </Button>
                </form>

                <p className="mt-4">
                    Don't have an account?{" "}
                    <Link href="/register" className="text-blue-500">
                        Register
                    </Link>
                </p>
            </main>
        </div>
    );
}

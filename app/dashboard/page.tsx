"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { Plus, FolderOpen, Clock, CheckCircle2 } from "lucide-react"
import Link from "next/link"

export default function DashboardPage() {
  const [projects] = useState([
    { id: "1", name: "123 Main Street", photoCount: 42, status: "completed", date: "2 days ago" },
    { id: "2", name: "456 Oak Avenue", photoCount: 38, status: "processing", date: "Today" },
    { id: "3", name: "789 Pine Road", photoCount: 51, status: "completed", date: "1 week ago" },
  ])

  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border">
        <div className="container mx-auto px-6 h-16 flex items-center justify-between">
          <Link href="/" className="text-xl font-medium">
            FotoAI
          </Link>
          <Button size="sm">
            <Plus className="mr-2 h-4 w-4" />
            New Project
          </Button>
        </div>
      </header>

      <main className="container mx-auto px-6 py-8">
        <div className="mb-8">
          <h1 className="text-3xl font-medium mb-2">Projects</h1>
          <p className="text-muted-foreground">Manage your photo projects</p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {projects.map((project) => (
            <Card key={project.id} className="p-6 hover:shadow-md transition-shadow cursor-pointer">
              <div className="flex items-start justify-between mb-4">
                <div className="flex items-center gap-3">
                  <div className="h-10 w-10 rounded bg-muted flex items-center justify-center">
                    <FolderOpen className="h-5 w-5 text-muted-foreground" />
                  </div>
                  <div>
                    <h3 className="font-medium">{project.name}</h3>
                    <p className="text-sm text-muted-foreground">{project.photoCount} photos</p>
                  </div>
                </div>
              </div>

              <div className="flex items-center justify-between text-sm">
                <span className="text-muted-foreground">{project.date}</span>
                {project.status === "completed" ? (
                  <span className="flex items-center gap-1 text-accent">
                    <CheckCircle2 className="h-4 w-4" />
                    Complete
                  </span>
                ) : (
                  <span className="flex items-center gap-1 text-muted-foreground">
                    <Clock className="h-4 w-4" />
                    Processing
                  </span>
                )}
              </div>
            </Card>
          ))}

          <Card className="p-6 border-dashed hover:bg-muted/30 transition-colors cursor-pointer">
            <div className="flex flex-col items-center justify-center h-full min-h-[140px] text-center">
              <Plus className="h-8 w-8 text-muted-foreground mb-2" />
              <p className="text-sm text-muted-foreground">Create new project</p>
            </div>
          </Card>
        </div>
      </main>
    </div>
  )
}

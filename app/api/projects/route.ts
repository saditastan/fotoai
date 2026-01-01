import { type NextRequest, NextResponse } from "next/server"

// Mock project data
const projects = [
  {
    id: "1",
    name: "Demo Proje 1",
    created: new Date().toISOString(),
    photoCount: 25,
    status: "completed",
  },
  {
    id: "2",
    name: "Demo Proje 2",
    created: new Date().toISOString(),
    photoCount: 50,
    status: "processing",
  },
]

export async function GET() {
  return NextResponse.json({ projects })
}

export async function POST(request: NextRequest) {
  const body = await request.json()

  const newProject = {
    id: Date.now().toString(),
    name: body.name || "Yeni Proje",
    created: new Date().toISOString(),
    photoCount: 0,
    status: "created",
  }

  projects.push(newProject)

  return NextResponse.json({ project: newProject }, { status: 201 })
}

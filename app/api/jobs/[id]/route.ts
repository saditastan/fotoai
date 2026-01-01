import { type NextRequest, NextResponse } from "next/server"

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  const { id } = await params

  // Mock job status with random progress
  const progress = Math.floor(Math.random() * 100)

  const job = {
    jobId: id,
    status: progress === 100 ? "completed" : "processing",
    progress: {
      total: 50,
      completed: Math.floor(50 * (progress / 100)),
      currentPhoto: progress < 100 ? `photo-${Math.floor(Math.random() * 50)}.jpg` : null,
    },
    startedAt: new Date(Date.now() - 120000).toISOString(),
    estimatedCompletion: new Date(Date.now() + 180000).toISOString(),
  }

  return NextResponse.json(job)
}

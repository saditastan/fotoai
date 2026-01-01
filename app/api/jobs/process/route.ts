import { type NextRequest, NextResponse } from "next/server"

export async function POST(request: NextRequest) {
  const body = await request.json()

  // Mock job creation
  const job = {
    jobId: `job-${Date.now()}`,
    status: "queued",
    projectId: body.projectId,
    photoIds: body.photoIds,
    totalPhotos: body.photoIds?.length || 0,
    completed: 0,
    estimatedCompletion: new Date(Date.now() + 300000).toISOString(), // 5 min
    startedAt: new Date().toISOString(),
  }

  return NextResponse.json(job, { status: 202 })
}

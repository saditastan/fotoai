import { type NextRequest, NextResponse } from "next/server"

export async function POST(request: NextRequest) {
  const formData = await request.formData()
  const files = formData.getAll("files")

  // Mock upload response
  const uploadedPhotos = files.map((file: any, index: number) => ({
    id: `photo-${Date.now()}-${index}`,
    filename: file.name,
    format: file.name.toLowerCase().endsWith(".dng") || file.name.toLowerCase().endsWith(".cr2") ? "RAW" : "JPG",
    size: file.size,
    uploadedAt: new Date().toISOString(),
    status: "uploaded",
  }))

  return NextResponse.json({
    success: true,
    uploadedCount: uploadedPhotos.length,
    photos: uploadedPhotos,
  })
}

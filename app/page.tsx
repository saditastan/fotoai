import Link from "next/link"
import { Button } from "@/components/ui/button"
import { ArrowRight, Upload, Zap, Shield } from "lucide-react"

export default function HomePage() {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border">
        <div className="container mx-auto px-6 h-16 flex items-center justify-between">
          <div className="text-xl font-medium">FotoAI</div>
          <Button asChild variant="ghost">
            <Link href="/dashboard">Dashboard</Link>
          </Button>
        </div>
      </header>

      <main className="container mx-auto px-6">
        <div className="max-w-3xl mx-auto py-24 space-y-8">
          <div className="space-y-4">
            <h1 className="text-5xl font-medium tracking-tight text-balance">
              Professional photo enhancement for real estate
            </h1>
            <p className="text-xl text-muted-foreground text-pretty">
              Process RAW files with AI-powered adjustments. Batch upload, automatic enhancement, privacy blur
              detection.
            </p>
          </div>

          <div className="flex gap-4">
            <Button asChild size="lg">
              <Link href="/dashboard">
                Get Started
                <ArrowRight className="ml-2 h-4 w-4" />
              </Link>
            </Button>
            <Button asChild variant="outline" size="lg">
              <Link href="/demo">View Demo</Link>
            </Button>
          </div>
        </div>

        <div className="max-w-5xl mx-auto py-24">
          <div className="grid md:grid-cols-3 gap-12">
            <div className="space-y-3">
              <div className="h-12 w-12 rounded-lg bg-accent/10 flex items-center justify-center">
                <Upload className="h-6 w-6 text-accent" />
              </div>
              <h3 className="text-lg font-medium">RAW Support</h3>
              <p className="text-sm text-muted-foreground">
                DNG, CR2, NEF, ARW formats. Automatic detection and optimized processing pipeline.
              </p>
            </div>

            <div className="space-y-3">
              <div className="h-12 w-12 rounded-lg bg-accent/10 flex items-center justify-center">
                <Zap className="h-6 w-6 text-accent" />
              </div>
              <h3 className="text-lg font-medium">Batch Processing</h3>
              <p className="text-sm text-muted-foreground">
                Upload 50+ photos at once. Sequential processing with progress tracking.
              </p>
            </div>

            <div className="space-y-3">
              <div className="h-12 w-12 rounded-lg bg-accent/10 flex items-center justify-center">
                <Shield className="h-6 w-6 text-accent" />
              </div>
              <h3 className="text-lg font-medium">Privacy Detection</h3>
              <p className="text-sm text-muted-foreground">
                Automatic window view detection. Manual blur control with shape tools.
              </p>
            </div>
          </div>
        </div>
      </main>

      <footer className="border-t border-border mt-24">
        <div className="container mx-auto px-6 py-8">
          <p className="text-sm text-muted-foreground text-center">
            Professional photo enhancement platform. Built for real estate photographers.
          </p>
        </div>
      </footer>
    </div>
  )
}

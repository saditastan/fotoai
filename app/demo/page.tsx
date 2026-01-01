"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Slider } from "@/components/ui/slider"
import { Progress } from "@/components/ui/progress"

export default function DemoPage() {
  const [lightMood, setLightMood] = useState([50])
  const [air, setAir] = useState([50])
  const [depth, setDepth] = useState([50])
  const [processing, setProcessing] = useState(false)
  const [progress, setProgress] = useState(0)

  const handleProcess = () => {
    setProcessing(true)
    setProgress(0)

    const interval = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          clearInterval(interval)
          setProcessing(false)
          return 100
        }
        return prev + 10
      })
    }, 300)
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-light tracking-tight mb-8">Demo - Fotoğraf Editörü</h1>

        <div className="grid lg:grid-cols-2 gap-8">
          <Card>
            <CardContent className="p-6">
              <div className="aspect-video bg-muted rounded-lg flex items-center justify-center mb-4">
                <span className="text-muted-foreground">Önizleme Görüntüsü</span>
              </div>
              <p className="text-sm text-muted-foreground">
                Demo mod: Gerçek fotoğraf işleme için Docker kurulumu gereklidir
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-6 space-y-6">
              <div>
                <label className="text-sm font-medium mb-2 block">Light Mood</label>
                <Slider value={lightMood} onValueChange={setLightMood} max={100} step={1} />
                <span className="text-xs text-muted-foreground">{lightMood[0]}%</span>
              </div>

              <div>
                <label className="text-sm font-medium mb-2 block">Air</label>
                <Slider value={air} onValueChange={setAir} max={100} step={1} />
                <span className="text-xs text-muted-foreground">{air[0]}%</span>
              </div>

              <div>
                <label className="text-sm font-medium mb-2 block">Depth</label>
                <Slider value={depth} onValueChange={setDepth} max={100} step={1} />
                <span className="text-xs text-muted-foreground">{depth[0]}%</span>
              </div>

              {processing && (
                <div className="space-y-2">
                  <Progress value={progress} />
                  <p className="text-sm text-muted-foreground text-center">İşleniyor... {progress}%</p>
                </div>
              )}

              <Button onClick={handleProcess} disabled={processing} className="w-full">
                {processing ? "İşleniyor..." : "İşle"}
              </Button>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}

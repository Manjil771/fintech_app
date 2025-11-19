# Keep rules from missing_rules.txt (as suggested by the R8 error)
-keep class javax.imageio.spi.ImageInputStreamSpi { *; }
-keep class javax.imageio.spi.ImageOutputStreamSpi { *; }
-keep class javax.imageio.spi.ImageReaderSpi { *; }
-keep class javax.imageio.spi.ImageWriterSpi { *; }
-keep class javax.imageio.spi.** { *; }
-keep class com.github.jaiimageio.impl.** { *; }
-keep interface javax.imageio.spi.ImageInputStreamSpi { *; }
-keep interface javax.imageio.spi.ImageOutputStreamSpi { *; }
-keep class javax.imageio.spi.ImageReaderSpi { *; }
-keep class javax.imageio.spi.ImageWriterSpi { *; }

# Keep rules for the missing java.awt classes
-keep class java.awt.Color { *; }
-keep class java.awt.Dimension { *; }
-keep class java.awt.Image { *; }
-keep class java.awt.Point { *; }
-keep class java.awt.Rectangle { *; }
-keep class java.awt.color.** { *; }
-keep class java.awt.image.** { *; }

# Keep OkHttp classes
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep ucrop classes
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**

# Keep rules for the missing javax.imageio classes (beyond spi)
-keep class javax.imageio.IIOException { *; }
-keep class javax.imageio.IIOImage { *; }
-keep class javax.imageio.ImageIO { *; }
-keep class javax.imageio.ImageReadParam { *; }
-keep class javax.imageio.ImageReader { *; }
-keep class javax.imageio.ImageTypeSpecifier { *; }
-keep class javax.imageio.ImageWriteParam { *; }
-keep class javax.imageio.ImageWriter { *; }
-keep class javax.imageio.event.** { *; }
-keep class javax.imageio.metadata.** { *; }
-keep class javax.imageio.plugins.jpeg.** { *; }
-keep class javax.imageio.stream.** { *; }

# Keep the service registration directory
-keepdirectories META-INF/services/**

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn java.awt.Color
-dontwarn java.awt.Dimension
-dontwarn java.awt.Image
-dontwarn java.awt.Point
-dontwarn java.awt.Rectangle
-dontwarn java.awt.color.ColorSpace
-dontwarn java.awt.color.ICC_ColorSpace
-dontwarn java.awt.color.ICC_Profile
-dontwarn java.awt.image.BandedSampleModel
-dontwarn java.awt.image.BufferedImage
-dontwarn java.awt.image.ColorModel
-dontwarn java.awt.image.ComponentColorModel
-dontwarn java.awt.image.ComponentSampleModel
-dontwarn java.awt.image.DataBuffer
-dontwarn java.awt.image.DataBufferByte
-dontwarn java.awt.image.DataBufferDouble
-dontwarn java.awt.image.DataBufferFloat
-dontwarn java.awt.image.DataBufferInt
-dontwarn java.awt.image.DataBufferShort
-dontwarn java.awt.image.DataBufferUShort
-dontwarn java.awt.image.DirectColorModel
-dontwarn java.awt.image.IndexColorModel
-dontwarn java.awt.image.MultiPixelPackedSampleModel
-dontwarn java.awt.image.PixelInterleavedSampleModel
-dontwarn java.awt.image.Raster
-dontwarn java.awt.image.RenderedImage
-dontwarn java.awt.image.SampleModel
-dontwarn java.awt.image.SinglePixelPackedSampleModel
-dontwarn java.awt.image.WritableRaster
-dontwarn javax.imageio.IIOException
-dontwarn javax.imageio.IIOImage
-dontwarn javax.imageio.ImageIO
-dontwarn javax.imageio.ImageReadParam
-dontwarn javax.imageio.ImageReader
-dontwarn javax.imageio.ImageTypeSpecifier
-dontwarn javax.imageio.ImageWriteParam
-dontwarn javax.imageio.ImageWriter
-dontwarn javax.imageio.event.IIOReadProgressListener
-dontwarn javax.imageio.event.IIOReadUpdateListener
-dontwarn javax.imageio.event.IIOReadWarningListener
-dontwarn javax.imageio.event.IIOWriteProgressListener
-dontwarn javax.imageio.event.IIOWriteWarningListener
-dontwarn javax.imageio.metadata.IIOInvalidTreeException
-dontwarn javax.imageio.metadata.IIOMetadata
-dontwarn javax.imageio.metadata.IIOMetadataFormat
-dontwarn javax.imageio.metadata.IIOMetadataFormatImpl
-dontwarn javax.imageio.metadata.IIOMetadataNode
-dontwarn javax.imageio.plugins.jpeg.JPEGHuffmanTable
-dontwarn javax.imageio.plugins.jpeg.JPEGImageWriteParam
-dontwarn javax.imageio.plugins.jpeg.JPEGQTable
-dontwarn javax.imageio.spi.IIORegistry
-dontwarn javax.imageio.spi.ImageInputStreamSpi
-dontwarn javax.imageio.spi.ImageOutputStreamSpi
-dontwarn javax.imageio.spi.ImageReaderSpi
-dontwarn javax.imageio.spi.ImageReaderWriterSpi
-dontwarn javax.imageio.spi.ImageWriterSpi
-dontwarn javax.imageio.spi.ServiceRegistry$Filter
-dontwarn javax.imageio.spi.ServiceRegistry
-dontwarn javax.imageio.stream.FileCacheImageInputStream
-dontwarn javax.imageio.stream.FileCacheImageOutputStream
-dontwarn javax.imageio.stream.ImageInputStream
-dontwarn javax.imageio.stream.ImageInputStreamImpl
-dontwarn javax.imageio.stream.ImageOutputStream
-dontwarn javax.imageio.stream.ImageOutputStreamImpl
-dontwarn javax.imageio.stream.MemoryCacheImageInputStream
-dontwarn javax.imageio.stream.MemoryCacheImageOutputStream
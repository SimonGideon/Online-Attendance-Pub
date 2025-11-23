module QrCodeGeneration
    extend ActiveSupport::Concern
  
    included do
      # Generate QR code PNG image (does not save to storage)
      def qr_code_png
        unless self
          return nil
        end
  
        qr = RQRCode::QRCode.new(generate_token, size: 10, level: :l)
  
        qr.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: "black",
          fill: "white",
          module_px_size: 6,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 200,
        )
      end

      # Legacy method for backward compatibility (no longer saves to S3)
      def generate_qr_code
        unless self
          return { error: "Lecturer not found" }
        end
  
        # QR code is now generated on-the-fly, no need to save
        { success: "QR code is available for display" }
      end
    end
  end
  
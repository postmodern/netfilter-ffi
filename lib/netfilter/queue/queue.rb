require 'ffi'

module FFI
  module NetFilter
    module Queue
      extend FFI::Library

      ffi_lib 'libnetfilter_queue'

      callback :nfq_callback, [:pointer, :pointer, :pointer, :pointer], :int

      attach_function :nfq_open, [], :pointer
      attach_function :nfq_open_nfnl, [:pointer], :pointer
      attach_function :nfq_close, [:pointer], :int

      attach_function :nfq_bind_pf, [:pointer, :uint16], :int
      attach_function :nfq_unbind_pf, [:pointer, :uint16], :int

      attach_function :nfq_create_queue, [:pointer, :uint16, :nfq_callback, :pointer], :pointer
      attach_function :nfq_destroy_queue, [:pointer], :int
      attach_function :nfq_handle_packet, [:pointer, :pointer, :int], :int
      attach_function :nfq_set_mode, [:pointer, :uint8, :uint], :int
      attach_function :nfq_set_queue_maxlen, [:pointer, :uint32], :int
      attach_function :nfq_set_verdict, [:pointer, :uint32, :uint32, :uint32, :pointer], :int
      attach_function :nfq_set_verdict_mark, [:pointer, :uint32, :uint32, :uint32, :uint32, :pointer], :int

      # Message parsing functions
      attach_function :nfq_get_msg_packet_hdr, [:pointer], :pointer
      attach_function :nfq_get_nfmark, [:pointer], :uint32
      attach_function :nfq_get_timestamp, [:pointer, :pointer], :int

      # Return 0 if not st
      attach_function :nfq_get_indev, [:pointer], :uint32
      attach_function :nfq_get_physindev, [:pointer], :uint32
      attach_function :nfq_get_outdev, [:pointer], :uint32
      attach_function :nfq_get_physoutdev, [:pointer], :uint32
      attach_function :nfq_get_indev_name, [:pointer, :pointer, :pointer], :int
      attach_function :nfq_get_physindev_name, [:pointer, :pointer, :char], :int
      attach_function :nfq_get_outdev_name, [:pointer, :pointer, :char], :int
      attach_function :nfq_get_physoutdev_name, [:pointer, :pointer, :char], :int
      attach_function :nfq_get_packet_hw, [:pointer], :pointer

      # Return -1 if problem, length otherwise
      attach_function :nfq_get_payload, [:pointer, :pointer], :int

      def Queue.open
        nfq_open
      end

      def Queue.close(handler)
        nfq_close(handler)
      end

      def Queue.create(handler,num,data=nil,&callback)
        CURRENT_CALLBACK = callback

        nfq_create_queue(handler,num,callback,data)
      end
    end
  end
end

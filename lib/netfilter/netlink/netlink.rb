require 'ffi'

module FFI
  module NetFilter
    module NetLink
      extend FFI::Library

      ffi_lib 'libnfnetlink'

      BUFFSIZE = 8192

      attach_function :nfnl_fd, [:pointer], :int
      attach_function :nfnl_open, [], :pointer
      attach_function :nfnl_close, [:pointer], :int
      attach_function :nfnl_subsys_open, [:pointer, :uint8, :uint8, :uint], :pointer
      attach_function :nfnl_subsys_close, [:pointer], :void
      attach_function :nfnl_set_rcv_buffer_size, [:pointer, :uint], :void
      attach_function :nfnl_send, [:pointer, :pointer], :int
      attach_function :nfnl_sendmsg, [:pointer, :pointer, :uint], :int
      attach_function :nfnl_send_iov, [:pointer, :pointer, :uint, :uint], :int
      attach_function :nfnl_fill_hdr, [:pointer, :pointer, :uint, :uint8, :uint16, :uint16, :uint16], :void
      # TODO: attach_function :nfnl_talk
      # TODO: attach_function :nfnl_listen

      # Receiving
      attach_function :nfnl_recv, [:pointer, :pointer, :size_t], :ssize_t
      attach_function :nfnl_callback_register, [:pointer, :uint8, :pointer], :int
      attach_function :nfnl_callback_unregister, [:pointer, :uint8], :int
      attach_function :nfnl_handle_packets, [:pointer, :pointer, :int], :int

      # Parsing
      attach_function :nfnl_parse_hdr, [:pointer, :pointer, :pointer], :pointer
      attach_function :nfnl_check_attributes, [:pointer, :pointer, :pointer], :int
      attach_function :nfnl_get_msg_first, [:pointer, :pointer, :size_t], :pointer
      attach_function :nfnl_get_msg_next, [:pointer, :pointer, :size_t], :pointer

      # Callback Verdicts
      CALLBACK_VERDICTS = [
        CALLBACK_FAILURE = -1, # failure
        CALLBACK_STOP = 0,     # stop
        CALLBACK_CONTINUE = 1  # keep iterating
      ]

      # join a certain netlink multicast group
      attach_function :nfnl_join, [:pointer, :uint], :int
      attach_function :nfnl_process, [:pointer, :pointer, :size_t], :int

      # iterator API
      attach_function :nfnl_iterator_create, [:pointer, :pointer, :size_t], :pointer
      attach_function :nfnl_iterator_destroy, [:pointer], :void
      attach_function :nfnl_iterator_process, [:pointer, :pointer], :int
      attach_function :nfnl_iterator_next, [:pointer, :pointer], :int

      # replacement for nfnl_listen
      attach_function :nfnl_catch, [:pointer], :int

      # replacement for nfnl_talk
      attach_function :nfnl_query, [:pointer, :pointer], :int

      # attribute handling functions
      attach_function :nfnl_addattr_l, [:pointer, :int, :int, :pointer, :int], :int
      attach_function :nfnl_addattr16, [:pointer, :int, :int, :uint16], :int
      attach_function :nfnl_addattr32, [:pointer, :int, :int, :uint32], :int
      attach_function :nfnl_nfa_addattr_l, [:pointer, :int, :int, :pointer, :int], :int
      attach_function :nfnl_nfa_addattr16, [:pointer, :int, :int, :uint16], :int
      attach_function :nfnl_nfa_addattr32, [:pointer, :int, :int, :uint32], :int
      attach_function :nfnl_parse_attr, [:pointer, :int, :pointer, :int], :int
      attach_function :nfnl_build_nfa_iovec, [:pointer, :pointer, :uint16, :uint32, :pointer], :void
      attach_function :nfnl_rcvbufsize, [:pointer, :uint], :uint

      attach_function :nfnl_dump_packet, [:pointer, :int, :pointer], :void

      # index to interface name API
      attach_function :nlif_open, [], :pointer
      attach_function :nlif_close, [:pointer], :void
      attach_function :nlif_fd, [:pointer], :int
      attach_function :nlif_query, [:pointer], :int
      attach_function :nlif_catch, [:pointer], :int
      attach_function :nlif_index2name, [:pointer, :uint, :pointer], :int
    end
  end
end

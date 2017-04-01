# Ruby bindings for the Keystone Engine
#
# Copyright(c) 2017 Sascha Schirra
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


require "ffi"
require "objspace"


module Keystone extend FFI::Library
    ffi_lib "keystone"

    class IntPtr < FFI::Struct
        layout  :value, :size_t
    end
    class KsEnginePtr < FFI::Struct
        layout :value, :pointer
    end
    class StringPtr < FFI::Struct
        layout :value, :pointer
    end

    attach_function :ks_open, [:int, :int, KsEnginePtr], :int
    attach_function :ks_close, [:pointer], :int
    attach_function :ks_errno, [:pointer], :int
    attach_function :ks_strerror, [:int], :pointer
    attach_function :ks_asm, [:pointer, :pointer, :uint64, StringPtr, IntPtr, IntPtr], :int

    class KsError < StandardError
    end

    class Ks
        private
        attr_accessor :ks

        public
        def initialize(arch, mode)
            _ks = KsEnginePtr.new
            err = Keystone::ks_open(arch, mode, _ks)
            if err != KS_ERR_OK
                raise KsError, Keystone::ks_strerror(err).read_string
            end
            @ks = _ks[:value]

            ObjectSpace.define_finalizer(self, proc{ Keystone::ks_close(ks) })
        end

        def asm(instructions, address=0)
            inst = FFI::MemoryPointer.from_string(instructions)
            bytes = StringPtr.new
            size = IntPtr.new 
            count = IntPtr.new
            err = Keystone::ks_asm(ks, inst, address, bytes, size, count)

            if err != KS_ERR_OK
                raise KsError, Keystone::ks_strerror(err).read_string
            end

            return [bytes[:value].read_string(size[:value]), count[:value]]
        end

    end

end
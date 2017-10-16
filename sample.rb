require "keystone_engine"
require "keystone_engine/keystone_const"
#ks = KsEnginePtr.new
include KeystoneEngine

ks = Ks.new(KS_ARCH_ARM,KS_MODE_ARM)
bytes, count = ks.asm('bx r3')
puts bytes

ks = Ks.new(KS_ARCH_X86,KS_MODE_32)
bytes, count = ks.asm('mov eax, 1')
puts bytes

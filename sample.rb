require "./keystone"
require "./keystone/keystone_const"
#ks = KsEnginePtr.new
include Keystone

ks = Ks.new(KS_ARCH_ARM,KS_MODE_ARM)
bytes, count = ks.asm('bx r3')
puts bytes

ks = Ks.new(KS_ARCH_X86,KS_MODE_32)
bytes, count = ks.asm('bx r3')
puts bytes
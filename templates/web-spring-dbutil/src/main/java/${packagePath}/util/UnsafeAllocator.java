package ${packageName}.util;

import java.io.ObjectInputStream;
import java.io.ObjectStreamClass;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public abstract class UnsafeAllocator {
    public UnsafeAllocator() {
    }

    public abstract <T> T newInstance(Class<T> var1) throws Exception;

    public static UnsafeAllocator create() {
        try {
            Class ignored1 = Class.forName("sun.misc.Unsafe");
            Field constructorId1 = ignored1.getDeclaredField("theUnsafe");
            constructorId1.setAccessible(true);
            final Object newInstance1 = constructorId1.get((Object)null);
            final Method allocateInstance = ignored1.getMethod("allocateInstance", new Class[]{Class.class});
            return new UnsafeAllocator() {
                public <T> T newInstance(Class<T> c) throws Exception {
                    return (T)allocateInstance.invoke(newInstance1, new Object[]{c});
                }
            };
        } catch (Exception var6) {
            try {
                final Method ignored;
                ignored = ObjectInputStream.class.getDeclaredMethod("newInstance", new Class[]{Class.class, Class.class});
                ignored.setAccessible(true);
                return new UnsafeAllocator() {
                    public <T> T newInstance(Class<T> c) throws Exception {
                        return (T)ignored.invoke((Object)null, new Object[]{c, Object.class});
                    }
                };
            } catch (Exception var5) {
                try {
                    Method ignored = ObjectStreamClass.class.getDeclaredMethod("getConstructorId", new Class[]{Class.class});
                    ignored.setAccessible(true);
                    final int constructorId = ((Integer)ignored.invoke((Object)null, new Object[]{Object.class})).intValue();
                    final Method newInstance = ObjectStreamClass.class.getDeclaredMethod("newInstance", new Class[]{Class.class, Integer.TYPE});
                    newInstance.setAccessible(true);
                    return new UnsafeAllocator() {
                        public <T> T newInstance(Class<T> c) throws Exception {
                            return (T)newInstance.invoke((Object)null, new Object[]{c, Integer.valueOf(constructorId)});
                        }
                    };
                } catch (Exception var4) {
                    return new UnsafeAllocator() {
                        public <T> T newInstance(Class<T> c) {
                            throw new UnsupportedOperationException("Cannot allocate " + c);
                        }
                    };
                }
            }
        }
    }
}

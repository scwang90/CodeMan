package ${packageName}.util;

import org.apache.tomcat.util.codec.binary.Base64;

import java.util.UUID;

public class ID22 {

    private String id22 = compressedUUID(UUID.randomUUID());

    private ID22() {

    }

    public static String randomID22() {
        return new ID22().id22;
    }

    private static String compressedUUID(UUID uuid) {
        byte[] byUuid = new byte[16];
        long least = uuid.getLeastSignificantBits();
        long most = uuid.getMostSignificantBits();
        long2bytes(most, byUuid, 0);
        long2bytes(least, byUuid, 8);
        return Base64.encodeBase64URLSafeString(byUuid);
    }

    private static void long2bytes(long value, byte[] bytes, int offset) {
        for (int i = 7; i > -1; i--) {
            bytes[offset++] = (byte) ((value >> 8 * i) & 0xFF);
        }
    }
}

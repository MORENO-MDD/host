import telebot
from telebot import types

# ⚠️ استبدل هذا التوكن بالتوكن الخاص بك من BotFather
BOT_TOKEN = "8182502843:AAEYBYvnvDdkssD_QDTs8JQwnZWRxrjn04M"

# إنشاء كائن البوت
bot = telebot.TeleBot(BOT_TOKEN)

# ✅ الرد على أمر /start
@bot.message_handler(commands=['start'])
def send_welcome(message):
    bot.reply_to(message, "👋 مرحبا بك! أنا بوتك الجديد. كيف يمكنني مساعدتك؟")

# ✅ الرد على أي رسالة نصية
@bot.message_handler(func=lambda message: True)
def handle_message(message):
    text = message.text
    
    # لو الرسالة فيها كلمة "استرات"
    if "استرات" in text:
        bot.reply_to(message, "👋 مرحبا! تسلم على السؤال، أنا بخير، كيف حالك؟")
    else:
        # رد افتراضي
        bot.reply_to(message, f"📩 أنت كتبت: {text}")

# ✅ تشغيل البوت
if __name__ == "__main__":
    print("🚀 البوت يعمل الآن...")
    bot.infinity_polling()
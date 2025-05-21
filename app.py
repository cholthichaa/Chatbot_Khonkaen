from flask import Flask, request, jsonify
from pythainlp import word_tokenize
from pythainlp.tag import NER

app = Flask(__name__)

# ใช้ Thainer สำหรับ NER
ner = NER("thainer")

# รายการสถานที่ที่รู้จัก (เพิ่มได้ตามความต้องการ)
KNOWN_PLACES = [
    "วัดพระบาทภูพานคำ",
    "อุทยานแห่งชาติภูเก้า-ภูพานคำ",
    "เชียงใหม่",
    "กรุงเทพมหานคร",
]

def extract_place_by_keywords(text):
    """
    ใช้การตัดคำและตรวจจับคีย์เวิร์ด เพื่อดึงชื่อสถานที่
    """
    words = word_tokenize(text)
    places = [word for word in words if word in KNOWN_PLACES]
    return places

def extract_places(text):
    """
    ดึงชื่อสถานที่จากข้อความโดยใช้ NER และ fallback ไปยังการตัดคำถ้าจำเป็น
    """
    # ใช้ NER ดึงชื่อสถานที่
    tagged_text = ner.tag(text)
    places = [word for word, tag in tagged_text if tag in ['LOCATION', 'ORGANIZATION']]

    # Fallback: ถ้า NER ไม่พบชื่อสถานที่ ใช้การตัดคำและตรวจจับคีย์เวิร์ด
    if not places:
        places = extract_place_by_keywords(text)

    return places

@app.route('/extract_places', methods=['POST'])
def api_extract_places():
    """
    API Endpoint สำหรับดึงชื่อสถานที่จากข้อความ
    """
    data = request.json
    text = data.get('text', '')

    if not text:
        return jsonify({"error": "No text provided"}), 400

    # ดึงชื่อสถานที่
    places = extract_places(text)

    return jsonify({
        'places': places
    })

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)

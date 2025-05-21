const line = require("@line/bot-sdk");

function createrestaurantFlexMessage() {
  return {
    type: "flex",
    altText: "ร้านอาหารขอนแก่น",
    contents: {
      hero: {
        size: "full",
        aspectMode: "cover",
        type: "image",
        aspectRatio: "20:13",
        action: {
          label: "Line",
          uri: "https://linecorp.com/",
          type: "uri",
        },
        url: "https://www.tripgether.com/wp-content/uploads/2023/08/5-%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%99%E0%B8%AD%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A3%E0%B8%82%E0%B8%AD%E0%B8%99%E0%B9%81%E0%B8%81%E0%B9%88%E0%B8%99-%E0%B8%9A%E0%B8%A3%E0%B8%A3%E0%B8%A2%E0%B8%B2%E0%B8%81%E0%B8%B2%E0%B8%A8%E0%B8%94%E0%B8%B5-%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%B1%E0%B8%99%E0%B8%95%E0%B8%B5%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%AD%E0%B8%A3%E0%B9%88%E0%B8%AD%E0%B8%A2-01.jpg",
      },
      body: {
        action: {
          type: "message",
          text: "ร้านอาหารขอนแก่น",
          label: "ประเภทร้านอาหารขอนแก่น",
        },
        type: "box",
        contents: [
          {
            color: "#000000FF",
            text: "เลือกประเภทร้านอาหารขอนแก่นเลยค่ะ",
            align: "start",
            weight: "regular",
            size: "md",
            contents: [],
            type: "text",
            margin: "md",
          },
          {
            text: "ประเภทร้านอาหารขอนแก่น",
            weight: "bold",
            type: "text",
            size: "xl",
            contents: [],
            color: "#000000FF",
            align: "start",
          },
          {
            margin: "xxl",
            size: "xs",
            type: "text",
            gravity: "bottom",
            align: "start",
            text: "ขอบคุณภาพจาก : tripgether",
            color: "#5B5858FF",
            weight: "regular",
            contents: [],
          },
        ],
        layout: "vertical",
      },
      footer: {
        layout: "vertical",
        contents: [
          {
            color: "#990099",
            action: {
              text: "ร้านอาหารระดับมิชลินไกด์",
              label: "ร้านอาหารระดับมิชลินไกด์",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "คาเฟ่ยอดฮิต",
              label: "คาเฟ่ยอดฮิต",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "บุฟเฟ่ชาบู หมูกะทะเจ้าดังขอนแก่น",
              label: "บุฟเฟ่ชาบู หมูกะทะเจ้าดังขอนแก่น",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "ร้านอาหารอีสาน",
              label: "อาหารอีสาน",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "ร้านอาหารไทย",
              label: "อาหารไทย",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "ร้านอาหารโกอินเตอร์",
              label: "อาหารโกอินเตอร์",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            color: "#990099",
            action: {
              text: "อาหารริมทาง",
              label: "ร้านอาหารริมทาง",
              type: "message",
            },
            style: "primary",
            type: "button",
            height: "sm",
          },
          {
            size: "sm",
            type: "spacer",
          },
        ],
        type: "box",
        spacing: "sm",
      },
      type: "bubble",
    },
  };
}

module.exports = {
  createrestaurantFlexMessage,
};

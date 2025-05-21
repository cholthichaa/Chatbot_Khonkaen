const line = require("@line/bot-sdk");

function createTypeFlexMessage() {
  return {
    contents: {
      type: "bubble",
      footer: {
        contents: [
          {
            type: "button",
            action: {
              text: "เลือกอำเภอกันเลย",
              label: "เลือกอำเภอกันเลย",
              type: "message",
            },
            height: "sm",
            style: "primary",
            color: "#571EDEFF",
          },
          {
            height: "sm",
            action: {
              label: "เลือกประเภทสถานที่",
              type: "message",
              text: "เลือกประเภทสถานที่",
            },
            style: "primary",
            type: "button",
            color: "#571EDEFF",
          },
          {
            height: "sm",
            type: "button",
            style: "primary",
            color: "#000080",
            action: {
              text: "ร้านอาหารดัง",
              label: "ร้านอาหารดัง",
              type: "message",
            },
          },

          {
            size: "sm",
            type: "spacer",
          },
        ],
        spacing: "sm",
        layout: "vertical",
        type: "box",
      },
      body: {
        layout: "vertical",
        type: "box",
        contents: [
          {
            align: "start",
            margin: "md",
            text: "เลือกโปรแกรมการเที่ยวเลยค่ะ",
            weight: "regular",
            size: "md",
            type: "text",
            color: "#000000FF",
          },
          {
            weight: "bold",
            color: "#000000FF",
            type: "text",
            size: "xl",
            align: "start",
            text: "ประเภทสถานที่ท่องเที่ยว",
          },
          {
            weight: "regular",
            gravity: "bottom",
            type: "text",
            size: "xs",
            margin: "xxl",
            text: "ขอบคุณภาพจาก : K@POOK!",
            color: "#5B5858FF",
            align: "start",
          },
        ],
      },
      hero: {
        action: {
          label: "Line",
          uri: "https://linecorp.com/",
          type: "uri",
        },
        aspectRatio: "20:13",
        size: "full",
        aspectMode: "cover",
        type: "image",
        url: "https://s359.kapook.com/pagebuilder/9e8a4cb1-cc1a-40f3-846b-b82e9871b1a8.jpg",
      },
    },
    altText: "สถานที่ท่องเที่ยวขอนแก่น",
    type: "flex",
  };
}

module.exports = {
  createTypeFlexMessage,
};

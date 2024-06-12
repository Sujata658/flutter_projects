const fs = require("fs");
const dataArray = [
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaa7",
    },
    starting: "1",
    ending: "2",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaa8",
    },
    starting: "1",
    ending: "3",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaa9",
    },
    starting: "1",
    ending: "4",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaaa",
    },
    starting: "1",
    ending: "5",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaab",
    },
    starting: "1",
    ending: "6",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaac",
    },
    starting: "1",
    ending: "7",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaad",
    },
    starting: "1",
    ending: "8",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaae",
    },
    starting: "1",
    ending: "9",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaaf",
    },
    starting: "1",
    ending: "10",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab0",
    },
    starting: "1",
    ending: "11",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab1",
    },
    starting: "1",
    ending: "12",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab2",
    },
    starting: "1",
    ending: "13",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab3",
    },
    starting: "1",
    ending: "14",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab4",
    },
    starting: "1",
    ending: "15",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab5",
    },
    starting: "1",
    ending: "16",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab6",
    },
    starting: "1",
    ending: "17",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab7",
    },
    starting: "1",
    ending: "18",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab8",
    },
    starting: "2",
    ending: "3",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aab9",
    },
    starting: "2",
    ending: "4",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaba",
    },
    starting: "2",
    ending: "5",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aabb",
    },
    starting: "2",
    ending: "6",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aabc",
    },
    starting: "2",
    ending: "7",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aabd",
    },
    starting: "2",
    ending: "8",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aabe",
    },
    starting: "2",
    ending: "9",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aabf",
    },
    starting: "2",
    ending: "10",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac0",
    },
    starting: "2",
    ending: "11",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac1",
    },
    starting: "2",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac2",
    },
    starting: "2",
    ending: "13",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac3",
    },
    starting: "2",
    ending: "14",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac4",
    },
    starting: "2",
    ending: "15",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac5",
    },
    starting: "2",
    ending: "16",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac6",
    },
    starting: "2",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac7",
    },
    starting: "2",
    ending: "18",
    rate: "35",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac8",
    },
    starting: "3",
    ending: "4",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aac9",
    },
    starting: "3",
    ending: "5",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaca",
    },
    starting: "3",
    ending: "6",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aacb",
    },
    starting: "3",
    ending: "7",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aacc",
    },
    starting: "3",
    ending: "8",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aacd",
    },
    starting: "3",
    ending: "9",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aace",
    },
    starting: "3",
    ending: "10",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aacf",
    },
    starting: "3",
    ending: "11",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad0",
    },
    starting: "3",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad1",
    },
    starting: "3",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad2",
    },
    starting: "3",
    ending: "14",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad3",
    },
    starting: "3",
    ending: "15",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad4",
    },
    starting: "3",
    ending: "16",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad5",
    },
    starting: "3",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad6",
    },
    starting: "3",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad7",
    },
    starting: "4",
    ending: "5",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad8",
    },
    starting: "4",
    ending: "6",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aad9",
    },
    starting: "4",
    ending: "7",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aada",
    },
    starting: "4",
    ending: "8",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aadb",
    },
    starting: "4",
    ending: "9",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aadc",
    },
    starting: "4",
    ending: "10",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aadd",
    },
    starting: "4",
    ending: "11",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aade",
    },
    starting: "4",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aadf",
    },
    starting: "4",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae0",
    },
    starting: "4",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae1",
    },
    starting: "4",
    ending: "15",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae2",
    },
    starting: "4",
    ending: "16",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae3",
    },
    starting: "4",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae4",
    },
    starting: "4",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae5",
    },
    starting: "5",
    ending: "6",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae6",
    },
    starting: "5",
    ending: "7",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae7",
    },
    starting: "5",
    ending: "8",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae8",
    },
    starting: "5",
    ending: "9",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aae9",
    },
    starting: "5",
    ending: "10",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaea",
    },
    starting: "5",
    ending: "11",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaeb",
    },
    starting: "5",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaec",
    },
    starting: "5",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaed",
    },
    starting: "5",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaee",
    },
    starting: "5",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaef",
    },
    starting: "5",
    ending: "16",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf0",
    },
    starting: "5",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf1",
    },
    starting: "5",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf2",
    },
    starting: "6",
    ending: "7",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf3",
    },
    starting: "6",
    ending: "8",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf4",
    },
    starting: "6",
    ending: "9",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf5",
    },
    starting: "6",
    ending: "10",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf6",
    },
    starting: "6",
    ending: "11",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf7",
    },
    starting: "6",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf8",
    },
    starting: "6",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaf9",
    },
    starting: "6",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aafa",
    },
    starting: "6",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aafb",
    },
    starting: "6",
    ending: "16",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aafc",
    },
    starting: "6",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aafd",
    },
    starting: "6",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aafe",
    },
    starting: "7",
    ending: "8",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0aaff",
    },
    starting: "7",
    ending: "9",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab00",
    },
    starting: "7",
    ending: "10",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab01",
    },
    starting: "7",
    ending: "11",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab02",
    },
    starting: "7",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab03",
    },
    starting: "7",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab04",
    },
    starting: "7",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab05",
    },
    starting: "7",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab06",
    },
    starting: "7",
    ending: "16",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab07",
    },
    starting: "7",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab08",
    },
    starting: "7",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab09",
    },
    starting: "8",
    ending: "9",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0a",
    },
    starting: "8",
    ending: "10",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0b",
    },
    starting: "8",
    ending: "11",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0c",
    },
    starting: "8",
    ending: "12",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0d",
    },
    starting: "8",
    ending: "13",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0e",
    },
    starting: "8",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab0f",
    },
    starting: "8",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab10",
    },
    starting: "8",
    ending: "16",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab11",
    },
    starting: "8",
    ending: "17",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab12",
    },
    starting: "8",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab13",
    },
    starting: "9",
    ending: "10",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab14",
    },
    starting: "9",
    ending: "11",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab15",
    },
    starting: "9",
    ending: "12",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab16",
    },
    starting: "9",
    ending: "13",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab17",
    },
    starting: "9",
    ending: "14",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab18",
    },
    starting: "9",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab19",
    },
    starting: "9",
    ending: "16",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1a",
    },
    starting: "9",
    ending: "17",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1b",
    },
    starting: "9",
    ending: "18",
    rate: "30",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1c",
    },
    starting: "10",
    ending: "11",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1d",
    },
    starting: "10",
    ending: "12",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1e",
    },
    starting: "10",
    ending: "13",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab1f",
    },
    starting: "10",
    ending: "14",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab20",
    },
    starting: "10",
    ending: "15",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab21",
    },
    starting: "10",
    ending: "16",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab22",
    },
    starting: "10",
    ending: "17",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab23",
    },
    starting: "10",
    ending: "18",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab24",
    },
    starting: "11",
    ending: "12",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab25",
    },
    starting: "11",
    ending: "13",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab26",
    },
    starting: "11",
    ending: "14",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab27",
    },
    starting: "11",
    ending: "15",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab28",
    },
    starting: "11",
    ending: "16",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab29",
    },
    starting: "11",
    ending: "17",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2a",
    },
    starting: "11",
    ending: "18",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2b",
    },
    starting: "12",
    ending: "13",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2c",
    },
    starting: "12",
    ending: "14",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2d",
    },
    starting: "12",
    ending: "15",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2e",
    },
    starting: "12",
    ending: "16",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab2f",
    },
    starting: "12",
    ending: "17",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab30",
    },
    starting: "12",
    ending: "18",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab31",
    },
    starting: "13",
    ending: "14",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab32",
    },
    starting: "13",
    ending: "15",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab33",
    },
    starting: "13",
    ending: "16",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab34",
    },
    starting: "13",
    ending: "17",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab35",
    },
    starting: "13",
    ending: "18",
    rate: "25",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab36",
    },
    starting: "14",
    ending: "15",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab37",
    },
    starting: "14",
    ending: "16",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab38",
    },
    starting: "14",
    ending: "17",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab39",
    },
    starting: "14",
    ending: "18",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3a",
    },
    starting: "15",
    ending: "16",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3b",
    },
    starting: "15",
    ending: "17",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3c",
    },
    starting: "15",
    ending: "18",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3d",
    },
    starting: "16",
    ending: "17",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3e",
    },
    starting: "16",
    ending: "18",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce4e0a101cfba07c0ab3f",
    },
    starting: "17",
    ending: "18",
    rate: "20",
    bus: "SY0",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab40",
    },
    starting: "1",
    ending: "2",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab41",
    },
    starting: "1",
    ending: "3",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab42",
    },
    starting: "1",
    ending: "4",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab43",
    },
    starting: "1",
    ending: "5",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab44",
    },
    starting: "1",
    ending: "6",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab45",
    },
    starting: "1",
    ending: "7",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab46",
    },
    starting: "1",
    ending: "8",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab47",
    },
    starting: "1",
    ending: "9",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab48",
    },
    starting: "1",
    ending: "10",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab49",
    },
    starting: "1",
    ending: "11",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4a",
    },
    starting: "1",
    ending: "12",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4b",
    },
    starting: "1",
    ending: "13",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4c",
    },
    starting: "1",
    ending: "14",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4d",
    },
    starting: "1",
    ending: "15",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4e",
    },
    starting: "1",
    ending: "55",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab4f",
    },
    starting: "1",
    ending: "56",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab50",
    },
    starting: "1",
    ending: "57",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab51",
    },
    starting: "1",
    ending: "58",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab52",
    },
    starting: "1",
    ending: "59",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab53",
    },
    starting: "1",
    ending: "60",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab54",
    },
    starting: "1",
    ending: "61",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab55",
    },
    starting: "1",
    ending: "62",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab56",
    },
    starting: "2",
    ending: "3",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab57",
    },
    starting: "2",
    ending: "4",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab58",
    },
    starting: "2",
    ending: "5",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab59",
    },
    starting: "2",
    ending: "6",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5a",
    },
    starting: "2",
    ending: "7",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5b",
    },
    starting: "2",
    ending: "8",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5c",
    },
    starting: "2",
    ending: "9",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5d",
    },
    starting: "2",
    ending: "10",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5e",
    },
    starting: "2",
    ending: "11",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab5f",
    },
    starting: "2",
    ending: "12",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab60",
    },
    starting: "2",
    ending: "13",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab61",
    },
    starting: "2",
    ending: "14",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab62",
    },
    starting: "2",
    ending: "15",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab63",
    },
    starting: "2",
    ending: "55",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab64",
    },
    starting: "2",
    ending: "56",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab65",
    },
    starting: "2",
    ending: "57",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab66",
    },
    starting: "2",
    ending: "58",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab67",
    },
    starting: "2",
    ending: "59",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab68",
    },
    starting: "2",
    ending: "60",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab69",
    },
    starting: "2",
    ending: "61",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6a",
    },
    starting: "2",
    ending: "62",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6b",
    },
    starting: "3",
    ending: "4",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6c",
    },
    starting: "3",
    ending: "5",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6d",
    },
    starting: "3",
    ending: "6",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6e",
    },
    starting: "3",
    ending: "7",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab6f",
    },
    starting: "3",
    ending: "8",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab70",
    },
    starting: "3",
    ending: "9",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab71",
    },
    starting: "3",
    ending: "10",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab72",
    },
    starting: "3",
    ending: "11",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab73",
    },
    starting: "3",
    ending: "12",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab74",
    },
    starting: "3",
    ending: "13",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab75",
    },
    starting: "3",
    ending: "14",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab76",
    },
    starting: "3",
    ending: "15",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab77",
    },
    starting: "3",
    ending: "55",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab78",
    },
    starting: "3",
    ending: "56",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab79",
    },
    starting: "3",
    ending: "57",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7a",
    },
    starting: "3",
    ending: "58",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7b",
    },
    starting: "3",
    ending: "59",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7c",
    },
    starting: "3",
    ending: "60",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7d",
    },
    starting: "3",
    ending: "61",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7e",
    },
    starting: "3",
    ending: "62",
    rate: "45",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab7f",
    },
    starting: "4",
    ending: "5",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab80",
    },
    starting: "4",
    ending: "6",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab81",
    },
    starting: "4",
    ending: "7",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab82",
    },
    starting: "4",
    ending: "8",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab83",
    },
    starting: "4",
    ending: "9",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab84",
    },
    starting: "4",
    ending: "10",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab85",
    },
    starting: "4",
    ending: "11",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab86",
    },
    starting: "4",
    ending: "12",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab87",
    },
    starting: "4",
    ending: "13",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab88",
    },
    starting: "4",
    ending: "14",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab89",
    },
    starting: "4",
    ending: "15",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8a",
    },
    starting: "4",
    ending: "55",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8b",
    },
    starting: "4",
    ending: "56",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8c",
    },
    starting: "4",
    ending: "57",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8d",
    },
    starting: "4",
    ending: "58",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8e",
    },
    starting: "4",
    ending: "59",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab8f",
    },
    starting: "4",
    ending: "60",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab90",
    },
    starting: "4",
    ending: "61",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab91",
    },
    starting: "4",
    ending: "62",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab92",
    },
    starting: "5",
    ending: "6",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab93",
    },
    starting: "5",
    ending: "7",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab94",
    },
    starting: "5",
    ending: "8",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab95",
    },
    starting: "5",
    ending: "9",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab96",
    },
    starting: "5",
    ending: "10",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab97",
    },
    starting: "5",
    ending: "11",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab98",
    },
    starting: "5",
    ending: "12",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab99",
    },
    starting: "5",
    ending: "13",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9a",
    },
    starting: "5",
    ending: "14",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9b",
    },
    starting: "5",
    ending: "15",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9c",
    },
    starting: "5",
    ending: "55",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9d",
    },
    starting: "5",
    ending: "56",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9e",
    },
    starting: "5",
    ending: "57",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ab9f",
    },
    starting: "5",
    ending: "58",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba0",
    },
    starting: "5",
    ending: "59",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba1",
    },
    starting: "5",
    ending: "60",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba2",
    },
    starting: "5",
    ending: "61",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba3",
    },
    starting: "5",
    ending: "62",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba4",
    },
    starting: "6",
    ending: "7",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba5",
    },
    starting: "6",
    ending: "8",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba6",
    },
    starting: "6",
    ending: "9",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba7",
    },
    starting: "6",
    ending: "10",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba8",
    },
    starting: "6",
    ending: "11",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0aba9",
    },
    starting: "6",
    ending: "12",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abaa",
    },
    starting: "6",
    ending: "13",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abab",
    },
    starting: "6",
    ending: "14",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abac",
    },
    starting: "6",
    ending: "15",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abad",
    },
    starting: "6",
    ending: "55",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abae",
    },
    starting: "6",
    ending: "56",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abaf",
    },
    starting: "6",
    ending: "57",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb0",
    },
    starting: "6",
    ending: "58",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb1",
    },
    starting: "6",
    ending: "59",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb2",
    },
    starting: "6",
    ending: "60",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb3",
    },
    starting: "6",
    ending: "61",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb4",
    },
    starting: "6",
    ending: "62",
    rate: "40",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb5",
    },
    starting: "7",
    ending: "8",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb6",
    },
    starting: "7",
    ending: "9",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb7",
    },
    starting: "7",
    ending: "10",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb8",
    },
    starting: "7",
    ending: "11",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abb9",
    },
    starting: "7",
    ending: "12",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abba",
    },
    starting: "7",
    ending: "13",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abbb",
    },
    starting: "7",
    ending: "14",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abbc",
    },
    starting: "7",
    ending: "15",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abbd",
    },
    starting: "7",
    ending: "55",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abbe",
    },
    starting: "7",
    ending: "56",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abbf",
    },
    starting: "7",
    ending: "57",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc0",
    },
    starting: "7",
    ending: "58",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc1",
    },
    starting: "7",
    ending: "59",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc2",
    },
    starting: "7",
    ending: "60",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc3",
    },
    starting: "7",
    ending: "61",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc4",
    },
    starting: "7",
    ending: "62",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc5",
    },
    starting: "8",
    ending: "9",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc6",
    },
    starting: "8",
    ending: "10",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc7",
    },
    starting: "8",
    ending: "11",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc8",
    },
    starting: "8",
    ending: "12",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abc9",
    },
    starting: "8",
    ending: "13",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abca",
    },
    starting: "8",
    ending: "14",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abcb",
    },
    starting: "8",
    ending: "15",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abcc",
    },
    starting: "8",
    ending: "55",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abcd",
    },
    starting: "8",
    ending: "56",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abce",
    },
    starting: "8",
    ending: "57",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abcf",
    },
    starting: "8",
    ending: "58",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd0",
    },
    starting: "8",
    ending: "59",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd1",
    },
    starting: "8",
    ending: "60",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd2",
    },
    starting: "8",
    ending: "61",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd3",
    },
    starting: "8",
    ending: "62",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd4",
    },
    starting: "9",
    ending: "10",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd5",
    },
    starting: "9",
    ending: "11",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd6",
    },
    starting: "9",
    ending: "12",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd7",
    },
    starting: "9",
    ending: "13",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd8",
    },
    starting: "9",
    ending: "14",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abd9",
    },
    starting: "9",
    ending: "15",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abda",
    },
    starting: "9",
    ending: "55",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abdb",
    },
    starting: "9",
    ending: "56",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abdc",
    },
    starting: "9",
    ending: "57",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abdd",
    },
    starting: "9",
    ending: "58",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abde",
    },
    starting: "9",
    ending: "59",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abdf",
    },
    starting: "9",
    ending: "60",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe0",
    },
    starting: "9",
    ending: "61",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe1",
    },
    starting: "9",
    ending: "62",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe2",
    },
    starting: "10",
    ending: "11",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe3",
    },
    starting: "10",
    ending: "12",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe4",
    },
    starting: "10",
    ending: "13",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe5",
    },
    starting: "10",
    ending: "14",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe6",
    },
    starting: "10",
    ending: "15",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe7",
    },
    starting: "10",
    ending: "55",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe8",
    },
    starting: "10",
    ending: "56",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abe9",
    },
    starting: "10",
    ending: "57",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abea",
    },
    starting: "10",
    ending: "58",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abeb",
    },
    starting: "10",
    ending: "59",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abec",
    },
    starting: "10",
    ending: "60",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abed",
    },
    starting: "10",
    ending: "61",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abee",
    },
    starting: "10",
    ending: "62",
    rate: "35",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abef",
    },
    starting: "11",
    ending: "12",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf0",
    },
    starting: "11",
    ending: "13",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf1",
    },
    starting: "11",
    ending: "14",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf2",
    },
    starting: "11",
    ending: "15",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf3",
    },
    starting: "11",
    ending: "55",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf4",
    },
    starting: "11",
    ending: "56",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf5",
    },
    starting: "11",
    ending: "57",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf6",
    },
    starting: "11",
    ending: "58",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf7",
    },
    starting: "11",
    ending: "59",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf8",
    },
    starting: "11",
    ending: "60",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abf9",
    },
    starting: "11",
    ending: "61",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abfa",
    },
    starting: "11",
    ending: "62",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abfb",
    },
    starting: "12",
    ending: "13",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abfc",
    },
    starting: "12",
    ending: "14",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abfd",
    },
    starting: "12",
    ending: "15",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abfe",
    },
    starting: "12",
    ending: "55",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0abff",
    },
    starting: "12",
    ending: "56",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac00",
    },
    starting: "12",
    ending: "57",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac01",
    },
    starting: "12",
    ending: "58",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac02",
    },
    starting: "12",
    ending: "59",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac03",
    },
    starting: "12",
    ending: "60",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac04",
    },
    starting: "12",
    ending: "61",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac05",
    },
    starting: "12",
    ending: "62",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac06",
    },
    starting: "13",
    ending: "14",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac07",
    },
    starting: "13",
    ending: "15",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac08",
    },
    starting: "13",
    ending: "55",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac09",
    },
    starting: "13",
    ending: "56",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0a",
    },
    starting: "13",
    ending: "57",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0b",
    },
    starting: "13",
    ending: "58",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0c",
    },
    starting: "13",
    ending: "59",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0d",
    },
    starting: "13",
    ending: "60",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0e",
    },
    starting: "13",
    ending: "61",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac0f",
    },
    starting: "13",
    ending: "62",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac10",
    },
    starting: "14",
    ending: "15",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac11",
    },
    starting: "14",
    ending: "55",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac12",
    },
    starting: "14",
    ending: "56",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac13",
    },
    starting: "14",
    ending: "57",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac14",
    },
    starting: "14",
    ending: "58",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac15",
    },
    starting: "14",
    ending: "59",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac16",
    },
    starting: "14",
    ending: "60",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac17",
    },
    starting: "14",
    ending: "61",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac18",
    },
    starting: "14",
    ending: "62",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac19",
    },
    starting: "15",
    ending: "55",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1a",
    },
    starting: "15",
    ending: "56",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1b",
    },
    starting: "15",
    ending: "57",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1c",
    },
    starting: "15",
    ending: "58",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1d",
    },
    starting: "15",
    ending: "59",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1e",
    },
    starting: "15",
    ending: "60",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac1f",
    },
    starting: "15",
    ending: "61",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac20",
    },
    starting: "15",
    ending: "62",
    rate: "30",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac21",
    },
    starting: "55",
    ending: "56",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac22",
    },
    starting: "55",
    ending: "57",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac23",
    },
    starting: "55",
    ending: "58",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac24",
    },
    starting: "55",
    ending: "59",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac25",
    },
    starting: "55",
    ending: "60",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac26",
    },
    starting: "55",
    ending: "61",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac27",
    },
    starting: "55",
    ending: "62",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac28",
    },
    starting: "56",
    ending: "57",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac29",
    },
    starting: "56",
    ending: "58",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2a",
    },
    starting: "56",
    ending: "59",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2b",
    },
    starting: "56",
    ending: "60",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2c",
    },
    starting: "56",
    ending: "61",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2d",
    },
    starting: "56",
    ending: "62",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2e",
    },
    starting: "57",
    ending: "58",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac2f",
    },
    starting: "57",
    ending: "59",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac30",
    },
    starting: "57",
    ending: "60",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac31",
    },
    starting: "57",
    ending: "61",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac32",
    },
    starting: "57",
    ending: "62",
    rate: "25",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac33",
    },
    starting: "58",
    ending: "59",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac34",
    },
    starting: "58",
    ending: "60",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac35",
    },
    starting: "58",
    ending: "61",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac36",
    },
    starting: "58",
    ending: "62",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac37",
    },
    starting: "59",
    ending: "60",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac38",
    },
    starting: "59",
    ending: "61",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac39",
    },
    starting: "59",
    ending: "62",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac3a",
    },
    starting: "60",
    ending: "61",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac3b",
    },
    starting: "60",
    ending: "62",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "658ce510a101cfba07c0ac3c",
    },
    starting: "61",
    ending: "62",
    rate: "20",
    bus: "SY1",
  },
  {
    _id: {
      $oid: "65bcf461669b5db9d2cc967c",
    },
    starting: "test",
    ending: "test",
    rate: 50,
    bus: "BYTEST",
    __v: 0,
  },
];

for (let i = 0; i < dataArray.length; i++) {
  if (dataArray[i].bus === "SY0") {
    dataArray[i].bus = "SaYa-L2NBP";
  } else if (dataArray[i].bus === "SY1") {
    dataArray[i].bus = "SaYa-L2B";
  }
}

const jsonString = JSON.stringify(dataArray, null, 2);

// Write the JSON string to a new file
fs.writeFileSync("updatedData.json", jsonString);

console.log("Data has been exported to updatedData.json");

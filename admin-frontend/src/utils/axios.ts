import axios from "axios";
axios.defaults.timeout = 200000;
axios.defaults.baseURL = "/api";

axios.interceptors.request.use(
  (config) => {
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

axios.interceptors.response.use(
  ({ data, config }) => {
    const { url, method } = config;
    const logMsg = `响应 ${url}\n`;
    console.log(logMsg);
    if (data.code === 200) {
      console.log(logMsg, data.content);
      return Promise.resolve(data.content);
    } else {
      console.log(logMsg, data);
      return Promise.reject(data);
    }
  },
  (error) => {
    const { message } = error;
    console.log({
      title: "错误提示",
      content: message,
    });
    return Promise.reject(message);
  }
);

export function get<T = any>(url: string, params?: any):Promise<T> {
  return axios.get(url, {
    params: params,
  }).then(response => response.data);
}

export function post<T = any>(url: string, params?: any):Promise<T> {
  return axios.post(url, params).then(response => response.data);
}
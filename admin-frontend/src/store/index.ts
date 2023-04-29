import { App } from "vue";
import { createPinia } from "pinia";

const store = createPinia();

export function setupStore(app: App<Element>) {
  app.use(store);
}

export function loadStroage(key: string, defaultVal: any) {
  const data = localStorage.getItem(key);
  return data ? JSON.parse(data) : defaultVal;
}

export { store };

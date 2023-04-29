interface IPost {
  title: string;
  date: string;
  content: string;
}

interface IPostSummary {
  id: number;
  title: string;
  date: string;
  summary: string;
}

interface IPostSummaryPage {
  page: number;
  total: number;
  records: Array<IPostSummary>;
}

interface IPostTitle{
  id: number;
  title: string;
  date: string;
}
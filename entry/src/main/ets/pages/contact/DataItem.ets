export interface ContactItem {
  name: string;
  head: Resource;
  chatPage?: string;
}

export default  interface DataItem {
  title: string;
  contactList: ContactItem[];
}
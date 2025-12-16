export interface ReportParameterDTO {
  name: string;
  type: string;
  value: any; // puedes afinar el tipo si lo conoces
}

export interface ReportRequest {
  reportName: string;
  extension: string;
  parameters: ReportParameterDTO[];
}

import { Injectable } from '@angular/core';
import autoTable from 'jspdf-autotable';
import { title } from 'process';

@Injectable({
  providedIn: 'root',
})
export class PdfService {
  constructor() {}
  private headerPdf(doc: any, title: any) {
    autoTable(doc, {
      styles: {
        fillColor: [255, 255, 255],
        textColor: [0, 0, 0],
        fontSize: 14,
        halign: 'center',
      },
      head: [title],
    });
  }
  pdfOneTable(doc: any, header: any, body: any) {
    this.headerPdf(doc, header[0]);
    autoTable(doc, {
      head: [header[1]],
      body: body,
    });
    doc.save(`${header[0]}.pdf`);
  }
}

import { routes } from './../../../routes/app.routes';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-router-menu',
  templateUrl: './router-menu.component.html',
  styleUrls: ['./router-menu.component.css']
})
export class RouterMenuComponent implements OnInit {

  items = routes;
  items2:any;
  listOutlet: string[];

  constructor(private router: Router) {
 
    this.listOutlet = [];
    let _self = this;
    this.items.forEach(function (item) {
      if (item.outlet && _self.listOutlet.indexOf(item.outlet)==-1) {
        _self.listOutlet.push(item.outlet);
      }
    });

    this.items2 = [
      {path: "listing/compagnie"},
      {path: "listing/repertoire"},
      {path: "listing/succes"},
    ]
    
  }

  ngOnInit() {
  }


  onclick(item) {
    if (item.outlet) {
      this.router.navigate([{ outlets: { [item.outlet]: item.path } }], {skipLocationChange : true});
    }
    else {
      this.router.navigate(["/" + item.path], {skipLocationChange : true});
    }

  }

  onCloseOutlet(_outlet){

    let obj = {};
    obj[_outlet] = null;
    this.router.navigate([{outlets: obj}], {skipLocationChange : true});
  }
}

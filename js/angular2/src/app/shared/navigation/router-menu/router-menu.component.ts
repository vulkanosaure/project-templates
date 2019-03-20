import { Router, Routes } from '@angular/router';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-router-menu',
  templateUrl: './router-menu.component.html',
  styleUrls: ['./router-menu.component.scss']
})
export class RouterMenuComponent implements OnInit {

  @Input() routes:Routes;
	listOutlet: string[];
	hidden:boolean = false;
	

  constructor(private router: Router) {

    
    
  }

  ngOnInit() {
		
		this.listOutlet = [];
    let _self = this;
    this.routes.forEach(function (item) {
      if (item.outlet && _self.listOutlet.indexOf(item.outlet)==-1) {
        _self.listOutlet.push(item.outlet);
      }
		});
		
  }


  onclick(item) {
		
		// console.log('onclick()');
    if (item.outlet) {
      this.router.navigate([{ outlets: { [item.outlet]: item.path } }], {skipLocationChange : false});
    }
    else {
      this.router.navigate(["/" + item.path], {skipLocationChange : false});
    }

  }

  onCloseOutlet(_outlet){

    let obj = {};
    obj[_outlet] = null;
    this.router.navigate([{outlets: obj}], {skipLocationChange : false});
	}
	
	
	keydown($event):void
	{
		if($event.code == "KeyR"){
			this.hidden = !this.hidden;
			
		}
	}
	
	
}

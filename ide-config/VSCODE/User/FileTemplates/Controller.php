<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use AppBundle\Form\UserType;
use Symfony\Component\Form\FormError;

class #{filename} extends Controller
{
    /**
     * @Route("/mypath", name="mypath_route")
	 * @Method({"GET"})
     */
    public function indexAction(Request $request)
    {
		//$em = $this->getDoctrine()->getManager();
		
		
		
		return $this->render('pages/template.html.twig', [
			
		]);
		
	}
	
	
	
	
}
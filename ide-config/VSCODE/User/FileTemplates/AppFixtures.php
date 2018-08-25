<?php


namespace AppBundle\DataFixtures\dev;


use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpKernel\Kernel;

class AppFixtures extends Fixture implements ContainerAwareInterface
{
		private $encoder;
		private $baseInit;
		/** @var ContainerInterface $container */
		private $container;
		
		
		/* 
		private $base_data = [
			['name' => 'Démo', 'key' => 'qs6df54qs65r4a6z5r4f6qs5fd4'],
			['name' => 'Telemarketing', 'key' => 'qs6df54qs65d4a6ze5r46sfqs6f54sdq5f'],
			['name' => 'Emailing', 'key' => 'a1F5D5s$F5hDmSmSP86G5Fsp8dd5sQ'],
			['name' => 'Prospection téléphonique', 'key' => 'Ag5dS'],
			['name' => 'Contacts evenementiels', 'key' => 'test'],
		];
		 */
		
		
		
	
    public function setContainer(ContainerInterface $container = null)
    {
        $this->container = $container;
    }
		
		
	public function __construct(UserPasswordEncoderInterface $encoder)
	{
		$this->encoder = $encoder;
		
	}
		
	
	
  public function load(ObjectManager $manager)
  {
		/** @var Kernel $kernel */
		$kernel = $this->container->get('kernel');
		if($kernel->getEnvironment() != 'dev') return;
		
		
		/* 
		//bases
		$len = count($this->base_data);
		for ($i = 0; $i < $len; $i++) {
				$obj = $this->base_data[$i];
				$item = new Base();
				$item->setName($obj['name']);
				$item->setKey($obj['key']);
				
				$manager->persist($item);
		}
		 */
		
		
		$manager->flush();
		
		
		
	}
}
	
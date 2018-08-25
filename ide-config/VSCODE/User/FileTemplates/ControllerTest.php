<?php

namespace Tests\AppBundle\Controller;

use AppBundle\DataFixtures\AppFixtures;
use AppBundle\Service\Debug;
use Tests\WebTestCase2;
use Symfony\Bundle\FrameworkBundle\Client;


class #{filename} extends WebTestCase2
{
	
	
	public static function setUpBeforeClass()
	{
		//static::initDatabase();
		
		
	}
	
	
	protected function setUp()
	{
		$client = static::createAuthClient();
		$client->enableProfiler();
		$client->disableReboot();
		$this->em = $client->getContainer()->get('doctrine.orm.entity_manager');
		$this->em->beginTransaction();
		$this->client = $client;
	}
	
	public function tearDown()
	{
		$this->em->rollback();
	}
	
	
	
	//_________________________________________________

	public function testIndex()
	{
		$client = $this->getClient();
		$crawler = $client->request('GET', '/path');
		
		static::checkException($client);
		static::assertTrue($client->getResponse()->isSuccessful());
		
		//$form = $crawler->selectButton('Enregistrer')->form();
		//static::assertEquals(4, $crawler->filter('small.text-danger')->count());
		// $this->assertContains('Mon compte', $crawler->filter('h2')->text());
		
	}
	
	
	
	
	
	
	
	/* 
	public function testIndex()
	{
		$client = $this->getClient();
		$crawler = $client->request('GET', '/path');
		static::assertTrue($client->getResponse()->isSuccessful());
		
		//$form = $crawler->selectButton('Enregistrer')->form();
		//static::assertEquals(4, $crawler->filter('small.text-danger')->count());
		// $this->assertContains('Mon compte', $crawler->filter('h2')->text());
		
	}
	 */
}
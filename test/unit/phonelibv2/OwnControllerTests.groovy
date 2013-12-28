package phonelibv2



import org.junit.*
import grails.test.mixin.*

@TestFor(OwnController)
@Mock(Own)
class OwnControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/own/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.ownInstanceList.size() == 0
        assert model.ownInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.ownInstance != null
    }

    void testSave() {
        controller.save()

        assert model.ownInstance != null
        assert view == '/own/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/own/show/1'
        assert controller.flash.message != null
        assert Own.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/own/list'


        populateValidParams(params)
        def own = new Own(params)

        assert own.save() != null

        params.id = own.id

        def model = controller.show()

        assert model.ownInstance == own
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/own/list'


        populateValidParams(params)
        def own = new Own(params)

        assert own.save() != null

        params.id = own.id

        def model = controller.edit()

        assert model.ownInstance == own
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/own/list'

        response.reset()


        populateValidParams(params)
        def own = new Own(params)

        assert own.save() != null

        // test invalid parameters in update
        params.id = own.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/own/edit"
        assert model.ownInstance != null

        own.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/own/show/$own.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        own.clearErrors()

        populateValidParams(params)
        params.id = own.id
        params.version = -1
        controller.update()

        assert view == "/own/edit"
        assert model.ownInstance != null
        assert model.ownInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/own/list'

        response.reset()

        populateValidParams(params)
        def own = new Own(params)

        assert own.save() != null
        assert Own.count() == 1

        params.id = own.id

        controller.delete()

        assert Own.count() == 0
        assert Own.get(own.id) == null
        assert response.redirectedUrl == '/own/list'
    }
}
